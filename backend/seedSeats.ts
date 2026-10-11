import "dotenv/config";
import { db } from "./src/prisma/db";

const cinemaIds = [2, 3, 4, 5];

const rows = ["A", "B", "C", "D", "E", "F", "G"];

async function main() {
  for (const cinemaId of cinemaIds) {
    for (const row of rows) {
      for (let number = 1; number <= 8; number++) {
        const seatNumber = `${row}${number}`;

        const existingSeat = await db.orm.public.Seat
          .where({
            cinemaId,
            seatNumber,
          })
          .first();

        if (!existingSeat) {
          await db.orm.public.Seat.create({
            cinemaId,
            seatNumber,
          });
        }
      }
    }
  }

  console.log("Seats added successfully!");
}

main().catch((error) => {
  console.error("Error adding seats:", error);
});