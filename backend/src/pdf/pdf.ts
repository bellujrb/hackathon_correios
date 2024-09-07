import { Router } from "express";
import multer from "multer";
import pdfParse from "pdf-parse";
import { getConnection } from "typeorm";
import { Line } from "../db/orm"; 

const pdfRouter = Router();
const upload = multer({ dest: "uploads/" });

pdfRouter.post("/upload", upload.single("pdf"), async (req, res) => {
  if (!req.file) {
    return res.status(400).send("No file uploaded.");
  }

  try {
    const dataBuffer = await pdfParse(req.file.path);
    const lines = dataBuffer.text.split("\n");

    const lineRepository = await getConnection().getRepository(Line);
    const lineEntities = lines.map(line => {
      const newLine = new Line();
      newLine.content = line.trim(); 
      return newLine;
    });

    await lineRepository.save(lineEntities);

    res.send("PDF uploaded and data saved.");
  } catch (error) {
    console.error(error);
    res.status(500).send("Error processing PDF.");
  }
});

export { pdfRouter };
