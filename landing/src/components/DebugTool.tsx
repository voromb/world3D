//src/components/DebugTool.tsx

"use client";

import React, { useState } from "react";

interface DebugToolProps {
  title: string;
  data: any;
  showInitially?: boolean;
}

const DebugTool: React.FC<DebugToolProps> = ({
  title,
  data,
  showInitially = false,
}) => {
  const [isExpanded, setIsExpanded] = useState(showInitially);

  return (
    <div className="mt-4 p-4 bg-gray-100 border border-gray-300 rounded-md">
      <div
        className="flex justify-between items-center cursor-pointer"
        onClick={() => setIsExpanded(!isExpanded)}
      >
        <h3 className="font-bold text-gray-800">{title}</h3>
        <span className="text-blue-600">{isExpanded ? "▼" : "▶"}</span>
      </div>

      {isExpanded && (
        <div className="mt-3">
          <pre className="bg-white p-3 rounded text-sm overflow-auto max-h-96">
            {typeof data === "object"
              ? JSON.stringify(data, null, 2)
              : String(data)}
          </pre>

          {/* Acciones adicionales si corresponde */}
          {Array.isArray(data) && (
            <div className="mt-2 text-sm text-gray-500">
              {data.length} items
            </div>
          )}
        </div>
      )}
    </div>
  );
};

export default DebugTool;
