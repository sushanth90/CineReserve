import express from "express";
import { db } from "../src/prisma/db";

const router = express.Router();

router.get("/", async (req, res) => {
  console.log("SHOW ROUTE HIT");

  try {
    const shows = await db.orm.public.Show.all();

    res.json(shows);
  } catch (error) {
    console.error("Error fetching shows:", error);
    res.status(500).json({
      message: "Failed to fetch shows",
    });
  }
});

export default router;