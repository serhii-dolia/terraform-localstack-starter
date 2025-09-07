"use strict";

/**
 * AWS Lambda handler (Node.js)
 * - Works with API Gateway proxy events and plain test events
 */
exports.handler = async function handleRequest(event, context) {
  const hasHttp = event && typeof event === "object" && "httpMethod" in event;

  const providedName =
    (event && event.queryStringParameters && event.queryStringParameters.name) ||
    (event && event.name) ||
    undefined;

  const name = providedName || "world";
  const message = `Hello, ${name}!`;

  if (hasHttp) {
    return {
      statusCode: 200,
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ message }),
    };
  }

  return { message };
};


