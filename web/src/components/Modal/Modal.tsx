import styles from './Modal.module.css';

type ModalProps = {
    isOpen: boolean;
    onClose: () => void;
    title: string;
    children: React.ReactNode;
    footer?: React.ReactNode;
};


export default function Modal({ isOpen, onClose, title, children, footer }: ModalProps) {

    if (!isOpen) return null;


    return (
        <div className={styles.modalCard}>
            <div className={styles.modalTop}>
                <h2>{title}</h2>
                <button
                    type="button"
                    onClick={onClose}
                    aria-label="Stäng modal"
                >×</button>
            </div>
            <div className={styles.modalMiddle}>
                {children}
            </div>

            <div className={styles.modalBottom}>
                {footer}
            </div>
        </div>
    )
}