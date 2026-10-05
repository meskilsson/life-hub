import styles from "./Navbar.module.css";
import { navRoutes } from "../../navigation/navRoutes";
import { Link } from "@tanstack/react-router";
import { useState } from "react";

export default function Navbar() {
    const [isOpen, setIsOpen] = useState(false);

    return (
        <nav className={styles.nav}>
            <button
                className={`${styles.menuButton} ${isOpen ? styles.openButton : ""}`}
                onClick={() => setIsOpen(!isOpen)}
                aria-label={isOpen ? "Close navigation" : "Open navigation"}
                aria-expanded={isOpen}
            >
                <span></span>
                <span></span>
                <span></span>
            </button>

            <ul className={`${styles.links} ${isOpen ? styles.open : styles.closed}`}>
                {navRoutes.map((route) => (
                    <li key={route.label} className={styles.link}>
                        <Link
                            to={route.path}
                            activeOptions={{ exact: route.path === "/" }}
                            activeProps={{ className: styles.active }}
                            onClick={() => setIsOpen(false)}
                        >
                            {route.label}
                        </Link>
                    </li>
                ))}
            </ul>
        </nav>
    );
}