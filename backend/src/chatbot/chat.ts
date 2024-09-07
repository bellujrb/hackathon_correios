import { AppDataSource } from "../db/db";
import { Line } from "../db/orm";
import { Like } from "typeorm";

export const findAnswer = async (question: string): Promise<string | null> => {
  const lineRepository = AppDataSource.getRepository(Line);

  const lines = await lineRepository.find({
    where: { content: Like(`%${question}%`) },
    take: 5,
  });

  return lines.length > 0 ? lines[0].content : null;
};
