import { Outlet } from "@tanstack/react-router";
import Navbar from "../components/Navbar/Navbar";

export default function RootLayout() {
    return (
        <>
            <Navbar />
            <Outlet />
        </>
    );
}