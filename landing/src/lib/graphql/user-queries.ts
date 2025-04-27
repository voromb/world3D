// src/lib/graphql/user-queries.ts
// Consultas relacionadas con usuarios y autenticación

export const GET_USER_PROFILE = `
  query GetUserProfile($userId: ID!) {
    usersPermissionsUser(documentId: $userId) {
      documentId
      username
      email
      avatar {
        data {
          attributes {
            url
            width
            height
            alternativeText
          }
        }
      }
    }
  }
`;

export const UPDATE_USER_PROFILE = `
  mutation UpdateUserProfile($userId: ID!, $username: String, $email: String, $currentPassword: String, $password: String, $confirmPassword: String) {
    updateUsersPermissionsUser(
      documentId: $userId,
      data: {
        username: $username,
        email: $email,
        password: $password
      }
    ) {
      documentId
      username
      email
    }
  }
`;

// Consulta para actualizar el avatar del usuario
// Nota: Esta mutación depende de cómo Strapi maneje la carga de archivos
// Esto es una aproximación - puede necesitar ajustes según la API exacta
export const UPDATE_USER_AVATAR = `
  mutation UpdateUserAvatar($userId: ID!, $avatarId: ID) {
    updateUsersPermissionsUser(
      documentId: $userId,
      data: {
        avatar: $avatarId
      }
    ) {
      documentId
      username
      avatar {
        data {
          attributes {
            url
          }
        }
      }
    }
  }
`;

// Consulta para registro de usuario - probada con curl
export const REGISTER_USER = `
  mutation RegisterUser($username: String!, $email: String!, $password: String!) {
    register(input: {
      username: $username,
      email: $email,
      password: $password
    }) {
      jwt
      user {
        id
        username
        email
      }
    }
  }
`;

// Consulta para login de usuario - probada con curl
export const LOGIN_USER = `
  mutation LoginUser($identifier: String!, $password: String!) {
    login(input: {
      identifier: $identifier,
      password: $password
    }) {
      jwt
      user {
        id
        username
        email
      }
    }
  }
`;
