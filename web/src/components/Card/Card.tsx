import styles from "./Card.module.css";
import type { HTMLAttributes, ReactNode } from "react";

type CardProps = HTMLAttributes<HTMLDivElement> & {
    size?: "sm" | "md" | "lg";
    variant?: "default" | "primary" | "secondary" | "danger" | "ghost";
    children: ReactNode;
};

export default function Card({ size = "md", variant = "default", children, className, ...props }: CardProps) {
    return (
        <div className={`${styles.card} ${styles[size]} ${styles[variant]} ${className ?? ""}`} {...props}>
            {children}
        </div>
    );
}