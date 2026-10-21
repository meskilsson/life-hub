import { motion, AnimatePresence } from 'motion/react';
import styles from './AnimationsPage.module.css';
import { useRef, useState } from 'react';
import { ArrowBigRightDash } from 'lucide-react';
import Card from '../../components/Card/Card';
import Button from '../../components/Button/Button';

export default function AnimationsPage() {

    const list = [
        { id: 1, label: "Objekt 1" },
        { id: 2, label: "Objekt 2" },
        { id: 3, label: "Objekt 3" },
    ];

    const containerRef = useRef<HTMLDivElement>(null);

    const [isOpen, setIsOpen] = useState(false);
    const [isExpanded, setIsExpanded] = useState(false);
    const [target, setTarget] = useState("Översikt");


    const [lista, setLista] = useState(list);


    function handleOpen() {
        setIsOpen((prev) => !prev);
    }

    function handleExpand() {
        setIsExpanded((prev) => !prev);
    }

    const nextId = useRef(4);

    function handleAdd() {
        const id = nextId.current;
        nextId.current += 1;

        const newItem = {
            id,
            label: `Objekt ${id}`,
        };

        setLista(prev => [...prev, newItem]);
    }

    return (
        <div
            className={styles.layout}
        >
            <motion.div
                className={styles.card}
                initial={{ opacity: 0, y: 20 }}
                animate={{ opacity: 1, y: 0 }}
                transition={{ duration: 1, ease: 'easeInOut' }}
            >
                <motion.button
                    className={styles.shrinkButton}
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.85 }}
                    transition={{ ease: 'easeInOut' }}
                >
                    shrink
                </motion.button>
            </motion.div>
            <div className={styles.cardContainer}>
                <motion.div
                    className={styles.cardOne}
                    initial={{ opacity: 0, x: -20 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ duration: 1, ease: 'easeIn', delay: 1 }}
                >1</motion.div>
                <motion.div
                    className={styles.cardTwo}
                    initial={{ opacity: 0, x: -20 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ duration: 1, ease: 'easeIn', delay: 2 }}
                >2</motion.div>
                <motion.div
                    className={styles.cardThree}
                    initial={{ opacity: 0, x: -20 }}
                    animate={{ opacity: 1, x: 0 }}
                    transition={{ duration: 1, ease: 'easeIn', delay: 3 }}
                >3</motion.div>
            </div>

            <div
                ref={containerRef}
                className={styles.dragContainer}>
                <motion.div
                    className={styles.drag}
                    drag
                    dragConstraints={containerRef}
                    dragElastic={0}
                    dragMomentum={false}

                >drag me</motion.div>
            </div>
            <div className={styles.menuContainer}>
                <motion.button
                    className={styles.menu}
                    onClick={handleOpen}
                    aria-label="Visa meny"
                    aria-expanded={isOpen}
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                    transition={{ type: "spring", stiffness: 400, damping: 30 }}
                >
                    <ArrowBigRightDash size={20} aria-hidden="true" className={styles.menuArrow} />
                </motion.button>
                <AnimatePresence>
                    {isOpen && (
                        <motion.ul
                            className={`${styles.links} ${isOpen ? styles.open : ''}`}
                            initial={{ opacity: 0, x: -8 }}
                            animate={{ opacity: 1, x: 0 }}
                            exit={{ opacity: 0, x: -8 }}
                            transition={{ duration: 0.2, ease: 'easeOut' }}
                        >
                            <li>Item 1</li>
                            <li>Item 2</li>
                            <li>Item 3</li>
                        </motion.ul>
                    )}
                </AnimatePresence>

            </div>

            <div className={styles.expandableCard}>
                <h2>Mitt kort</h2>

                <motion.button
                    onClick={handleExpand}
                    aria-expanded={isExpanded}
                    whileHover={{ scale: 1.05 }}
                    whileTap={{ scale: 0.95 }}
                >
                    {isExpanded ? 'Visa mindre' : 'Visa mer'}
                </motion.button>

                <AnimatePresence>
                    {isExpanded && (
                        <motion.div
                            initial={{ height: 0, opacity: 0 }}
                            animate={{ height: 'auto', opacity: 1 }}
                            exit={{ height: 0, opacity: 0 }}
                            transition={{ duration: 0.3, ease: 'easeInOut' }}
                            className={styles.description}
                        >
                            <p>Här finns mer information om kortet.</p>
                        </motion.div>
                    )}
                </AnimatePresence>
            </div>
            <div className={styles.flikar}>
                <motion.button onClick={() => setTarget('Översikt')}>
                    Översikt

                    {target === 'Översikt' && (
                        <motion.span
                            className={styles.underline}
                            layoutId="underline"
                        />
                    )}
                </motion.button>
                <motion.button
                    onClick={() => setTarget('Statistik')}
                >Statistik

                    {target === "Statistik" && (
                        <motion.span
                            className={styles.underline}
                            layoutId="underline"
                        />
                    )}
                </motion.button>
                <motion.button
                    onClick={() => setTarget('Historik')}
                >Historik

                    {target === "Historik" && (
                        <motion.span
                            className={styles.underline}
                            layoutId='underline'
                        />
                    )}
                </motion.button>
                <AnimatePresence mode="wait">
                    {target === "Översikt" && (
                        <motion.div
                            key="overview"
                            initial={{ y: 0, opacity: 0 }}
                            animate={{ y: 20, opacity: 1 }}
                            exit={{ y: 0, opacity: 0 }}
                            transition={{ duration: 0.3, ease: 'easeInOut' }}
                            className={styles.description}
                        >
                            <p>
                                Lorem ipsum dolor,
                                sit amet consectetur adipisicing elit.
                                Placeat, voluptatem vitae? Cumque unde
                                , assumenda labore reiciendis numquam optio harum in accusantium.
                                Illo nam a reiciendis. Reprehenderit beatae numquam optio suscipit.
                            </p>
                        </motion.div>
                    )}
                    {target === "Statistik" && (
                        <motion.div
                            key="statistics"
                            initial={{ y: 0, opacity: 0 }}
                            animate={{ y: 20, opacity: 1 }}
                            exit={{ y: 0, opacity: 0 }}
                            transition={{ duration: 0.2, ease: 'easeInOut' }}
                        >
                            <ul>
                                <li>Exempel 1</li>
                                <li>Exempel 2</li>
                                <li>Exempel 3</li>
                            </ul>
                        </motion.div>
                    )}
                    {target === "Historik" && (
                        <motion.div
                            key="history"
                            initial={{ y: 0, opacity: 0 }}
                            animate={{ y: 20, opacity: 1 }}
                            exit={{ y: 0, opacity: 0 }}
                            transition={{ duration: 0.2, ease: 'easeInOut' }}
                        >
                            <p>
                                historikkkkkkkkkkkkkkkkkkkkkk
                            </p>
                        </motion.div>
                    )}
                </AnimatePresence>
            </div>


            <div className={styles.listContainer}>
                <ul>
                    <AnimatePresence>
                        {lista.map((l) => (

                            <motion.li
                                key={l.id}
                                layout
                                initial={{ opacity: 0 }}
                                animate={{ opacity: 1 }}
                                exit={{ opacity: 0, x: 20 }}
                                transition={{ duration: 0.2, ease: 'easeInOut' }}
                                className={styles.list}
                            >
                                {l.label}
                                <motion.button
                                    onClick={() => setLista(prev => prev.filter(item => item.id !== l.id))}
                                >Ta bort
                                </motion.button>

                                <motion.button
                                    onClick={handleAdd}
                                >Lägg till</motion.button>
                            </motion.li>


                        ))}
                    </AnimatePresence>
                </ul>
            </div>

            <div className={styles.legacyExamples}>

                <Card>
                    <Button
                        variant='primary'
                        className={styles.legacyGrowButton}
                    >
                        onHover
                    </Button>
                </Card>

                <div
                    className={styles.legacyCardTone}
                >
                    Ruta
                </div>

                <div className={styles.legacyAnimationGlide}>
                    <Card
                        variant="secondary"
                    >
                        Glida in kort
                    </Card>
                </div>

                <div className={styles.legacyBall}></div>

                <div className={styles.legacyCardContainer}>
                    <motion.div initial={{ opacity: 0, x: '-100%' }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ duration: 3, ease: 'easeInOut' }}
                        className={styles.legacyCardOne}>1</motion.div>
                    <motion.div
                        initial={{ opacity: 0, x: '-100%' }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ duration: 3, ease: 'easeInOut' }}
                        className={styles.legacyCardTwo}>2</motion.div>
                    <motion.div
                        initial={{ opacity: 0, x: '-100%' }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ duration: 2, ease: 'easeInOut' }}
                        className={styles.legacyCardThree}>3</motion.div>
                </div>
            </div>
        </div>
    );
}
