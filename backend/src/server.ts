import "reflect-metadata";
import express from "express";
import { connectToDatabase } from "./db/db";
import { pdfRouter } from "./pdf/pdf";
import faqController from "./chatbot/control";

const app = express();

// Conecta ao banco de dados
connectToDatabase()
  .then(() => {
    app.use("/api", pdfRouter);
    app.use("/api", faqController);

    const PORT = 3000;
    app.listen(PORT, () => {
      console.log(`Server is running on port ${PORT}`);
    });
  })
  .catch((error) => {
    console.error("Failed to start the server:", error);
  });
