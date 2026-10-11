import express from "express";
import { db } from "../src/prisma/db";

const router = express.Router();

router.get("/", async (req, res) => {
  console.log("MOVIE ROUTE HIT");
  try {
    const movies = await db.orm.public.Movie.all();

    res.json(movies);
  } catch (error) {
    console.error("Error fetching movies:", error);

  console.log("PRISMA ERROR:", error);
res.status(500).json({
  message: "Failed to fetch movies"
});
  }
});

export default router;