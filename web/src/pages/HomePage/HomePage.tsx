import { useEffect, useState } from 'react';
import styles from './HomePage.module.css';
import Card from '../../components/Card/Card';
import Button from '../../components/Button/Button';


export default function HomePage() {
    const [loaded, setLoaded] = useState(false);
    const [selectedStair, setSelectedStair] = useState<number | null>(null);

    useEffect(() => {
        let secondFrame = 0;
        const firstFrame = requestAnimationFrame(() => {
            secondFrame = requestAnimationFrame(() => setLoaded(true));
        });

        return () => {
            cancelAnimationFrame(firstFrame);
            cancelAnimationFrame(secondFrame);
        };
    }, []);

    return (
        <div className={styles.layout}>


            <div className={`${styles.animations} ${loaded ? styles.loaded : ''}`}>
                {[styles.stairOne, styles.stairTwo, styles.stairThree, styles.stairFour].map((className, index) => (
                    <button
                        key={className}
                        type="button"
                        className={className}
                        aria-pressed={selectedStair === index}
                        onClick={() => setSelectedStair(index)}
                    >
                        Stair {index + 1}
                    </button>
                ))}
            </div>

            <Card
                variant="horizontal-lines-sm"
                size="lg"
            >
                <h2 className={styles.header}>HEADER</h2>

                <div className={styles.buttons}>
                    <Button
                        variant="default"
                        size="md"
                        onClick={() => console.log("clicked")}
                    >
                        default
                    </Button>
                    <Button
                        variant="primary"
                        size="md"
                        onClick={() => console.log("clicked")}
                    >
                        primary
                    </Button>
                    <Button
                        variant="secondary"
                        size="md"
                        onClick={() => console.log("clicked")}
                    >
                        secondary
                    </Button>
                    <Button
                        variant="danger"
                        size="md"
                        onClick={() => console.log("clicked")}
                    >
                        danger
                    </Button>
                    <Button
                        variant="ghost"
                        size="md"
                        onClick={() => console.log("clicked")}
                    >
                        ghost
                    </Button>
                </div>
            </Card>
        </div>
    )
}
