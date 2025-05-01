import { useState, useEffect, useCallback } from "react"

import type { ToastActionElement, ToastProps } from "@/components/ui/toast"

const TOAST_LIMIT = 5
const TOAST_REMOVE_DELAY = 5000

type ToasterToast = ToastProps & {
  id: string
  title?: React.ReactNode
  description?: React.ReactNode
  action?: ToastActionElement
}

const actionTypes = {
  ADD_TOAST: "ADD_TOAST",
  UPDATE_TOAST: "UPDATE_TOAST",
  DISMISS_TOAST: "DISMISS_TOAST",
  REMOVE_TOAST: "REMOVE_TOAST",
} as const

type ActionType = typeof actionTypes

interface Action {
  type: keyof ActionType
  toast?: Partial<ToasterToast> & { id: string } // Garantiza que id siempre esté presente
  toastId?: string
}

interface State {
  toasts: ToasterToast[]
}

const toastTimeouts = new Map<string, ReturnType<typeof setTimeout>>()

function useToastReducer(initialState: State) {
  const [state, setState] = useState<State>(initialState)

  const dispatch = useCallback((action: Action) => {
    switch (action.type) {
      case "ADD_TOAST":
        setState((prevState) => {
          const newToast = action.toast as ToasterToast
          const newState = {
            ...prevState,
            toasts: [
              ...prevState.toasts,
              { ...newToast, id: newToast.id },
            ].slice(-TOAST_LIMIT),
          }

          return newState
        })
        break

      case "UPDATE_TOAST":
        setState((prevState) => {
          const { toastId, toast } = action
          const toasts = prevState.toasts.map((t) =>
            t.id === toastId ? { ...t, ...(toast || {}) } : t
          )

          return { ...prevState, toasts }
        })
        break

      case "DISMISS_TOAST": {
        const { toastId } = action

        if (toastId) {
          const timeout = toastTimeouts.get(toastId)
          if (timeout) clearTimeout(timeout)

          toastTimeouts.set(
            toastId,
            setTimeout(() => {
              setState((prevState) => {
                const toasts = prevState.toasts.filter((t) => t.id !== toastId)
                return { ...prevState, toasts }
              })
              toastTimeouts.delete(toastId)
            }, TOAST_REMOVE_DELAY)
          )

          setState((prevState) => {
            const toasts = prevState.toasts.map((t) =>
              t.id === toastId ? { ...t, open: false } : t
            )
            return { ...prevState, toasts }
          })
        }
        break
      }

      case "REMOVE_TOAST":
        if (action.toastId) {
          setState((prevState) => {
            const toasts = prevState.toasts.filter((t) => t.id !== action.toastId)
            return { ...prevState, toasts }
          })
        }
        break
    }
  }, [])

  return [state, dispatch] as const
}

export function useToast() {
  const [state, dispatch] = useToastReducer({ toasts: [] })

  useEffect(() => {
    const timeouts: ReturnType<typeof setTimeout>[] = []
    
    state.toasts.forEach((toast) => {
      if (toast.open === false) return

      // Establecer un timeout para cerrar cada toast automáticamente
      const timeout = setTimeout(() => {
        dispatch({ type: "DISMISS_TOAST", toastId: toast.id })
      }, toast.duration || 5000)
      
      timeouts.push(timeout)
    })

    // Limpiar todos los timeouts cuando el componente se desmonte o cambie el estado
    return () => {
      timeouts.forEach(clearTimeout)
    }
  }, [state.toasts, dispatch])

  const toast = useCallback(
    (props: Omit<ToasterToast, "id"> & { id?: string }) => {
      const id = props.id || String(Date.now())
      dispatch({
        type: "ADD_TOAST",
        toast: {
          ...props,
          id,
          open: true,
          onOpenChange: (open) => {
            if (!open) dispatch({ type: "DISMISS_TOAST", toastId: id })
          },
        },
      })
      return id
    },
    [dispatch]
  )

  const update = useCallback(
    (id: string, props: Partial<Omit<ToasterToast, "id">>) => {
      dispatch({
        type: "UPDATE_TOAST",
        toastId: id,
        toast: {
          id,
          ...props
        },
      })
    },
    [dispatch]
  )

  const dismiss = useCallback(
    (id: string) => {
      dispatch({ type: "DISMISS_TOAST", toastId: id })
    },
    [dispatch]
  )

  return {
    toasts: state.toasts,
    toast,
    dismiss,
    update,
  }
}