import type { ButtonHTMLAttributes } from 'react';
import styles from './Button.module.css';


type ButtonProps = ButtonHTMLAttributes<HTMLButtonElement> & {
    variant?: "default" | "primary" | "secondary" | "ghost" | "danger";
    size?: "sm" | "md" | "lg" | "xl";
}

export default function Button({ size = "md", variant = "default", className, children, ...props }: ButtonProps) {
    return (
        <button className={` ${styles.button} ${styles[size]} ${styles[variant]} ${className ?? ""}`} {...props}>
            {children}
        </button>
    )
}