import { useState } from 'react';
import styles from './TrainingPage.module.css';


export default function TrainingPage() {


    const [isOpen, setIsOpen] = useState(false);

    function handleOpen() {
        setIsOpen((prev) => !prev);
    }

    return (
        <div className={styles.layout}>

            <div className={styles.menuContainer}>
                <button onClick={handleOpen} aria-expanded={isOpen}
                    className={styles.menu}
                >
                    Meny
                </button>

                <ul className={`${styles.links} ${isOpen ? styles.clicked : ""}`}>
                    <li>one</li>
                    <li>two</li>
                    <li>three</li>
                </ul>
            </div>

            <div className={styles.card}>
                onHover
            </div>
            <div className={styles.circlePadding}>
                <div className={styles.loadingCircle}></div>
            </div>

            <div className={styles.buttonPadding}>
                <button className={styles.buttonPulse}>pulse</button>
            </div>

        </div>
    );
}