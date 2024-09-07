import express, { Request, Response } from "express";
import { findAnswer } from "./chat";

const router = express.Router();

router.post("/ask", async (req: Request, res: Response) => {
  const { question } = req.body;

  if (!question) {
    return res.status(400).send("Question is required");
  }

  try {
    const answer = await findAnswer(question);

    if (answer) {
      res.json({ answer });
    } else {
      res.status(404).json({ message: "No answer found for that question." });
    }
  } catch (error) {
    res.status(500).json({ message: "An error occurred", error });
  }
});

export default router;
