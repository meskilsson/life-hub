import styles from './HomePage.module.css';
import Card from '../components/Card/Card';
import Button from '../components/Button/Button';


export default function HomePage() {
    return (
        <div className={styles.layout}>
            <Card
                variant="default"
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