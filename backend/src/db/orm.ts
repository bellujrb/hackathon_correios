import { Entity, PrimaryGeneratedColumn, Column } from "typeorm";

@Entity()
export class Line {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  content: string;
}

@Entity()
export class FAQ {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  question: string;

  @Column()
  answer: string;
}