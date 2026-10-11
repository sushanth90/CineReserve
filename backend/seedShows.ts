import "dotenv/config";

import { db } from "./src/prisma/db";

const cinemas = [2, 3, 4, 5];

const times = [
  "10:00 AM",
  "1:30 PM",
  "4:30 PM",
  "7:30 PM",
];

const formats = [
  "2D",
  "3D",
  "IMAX",
  "4DX",
];

async function main() {
  for (let movieId = 1; movieId <= 16; movieId++) {
    for (let day = 10; day <= 23; day++) {
      const date = `2026-10-${String(day).padStart(2, "0")}`;

      for (let cinemaIndex = 0; cinemaIndex < cinemas.length; cinemaIndex++) {
        const cinemaId = cinemas[cinemaIndex];
        const time = times[cinemaIndex];
        const format = formats[cinemaIndex];

        const existingShow = await db.orm.public.Show
          .where({
            movieId,
            cinemaId,
            date,
            time,
          })
          .first();

        if (!existingShow) {
          await db.orm.public.Show.create({
            movieId,
            cinemaId,
            date,
            time,
            format,
          });
        }
      }
    }
  }

  console.log("Shows from 10 Oct to 23 Oct added successfully!");
}

main().catch((error) => {
  console.error("Error adding shows:", error);
});