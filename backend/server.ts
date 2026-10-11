import express from "express";
import cors from "cors";
import movieRoutes from "./routes/movieRoutes";
import showRoutes from "./routes/showRoutes";
import bookingRoutes from "./routes/bookingRoutes";
import authRoutes from "./routes/authRoutes";

const app = express();

app.use(cors());
app.use(express.json());
app.use("/api/movies", movieRoutes);
app.use("/api/shows", showRoutes);
app.use("/api/bookings", bookingRoutes);
app.use("/api/auth", authRoutes);

app.get("/", (req, res) => {
  res.send("CineReserve Backend is running!");
});

const PORT = 5000;

app.listen(PORT, () => {
  console.log(`CineReserve backend running on http://localhost:${PORT}`);
});