import styles from './WeightPage.module.css';
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query';
import { createWeightResponse, getWeightResponse, deleteWeightByIdResponse, updateWeightByIdResponse } from '../../services/weightService';
import { motion } from 'motion/react';
import type { SubmitEvent } from 'react';
import { useState } from 'react';
import Modal from '../../components/Modal/Modal';
import { createSleepHoursResponse, deleteSleepHoursById, getSleepHoursResponse, updateSleepHoursById } from '../../services/hourService';
import Button from '../../components/Button/Button';
import Card from '../../components/Card/Card';



export default function WeightPage() {

    const queryClient = useQueryClient();

    const [selectedWeightId, setSelectedWeightId] = useState<number | null>(null);
    const [selectedSleepHoursId, setSelectedSleepHoursId] = useState<number | null>(null);
    const [weightModalOpen, setWeightModalOpen] = useState(false);
    const [sleepHoursModalOpen, setSleepHoursModalOpen] = useState(false);


    const {
        data: weights = [],
        isPending: weightsPending,
        error: weightsError,
    } = useQuery({
        queryKey: ['weights'],
        queryFn: getWeightResponse,
    });

    const {
        data: sleepHours = [],
        isPending: hoursPending,
        error: hoursError,
    } = useQuery({
        queryKey: ['sleepHours'],
        queryFn: getSleepHoursResponse,
    });

    const createWeight = useMutation({
        mutationFn: createWeightResponse,
        onSuccess: () =>
            queryClient.invalidateQueries({ queryKey: ['weights'] }),
    });

    const createSleepHours = useMutation({
        mutationFn: createSleepHoursResponse,
        onSuccess: () =>
            queryClient.invalidateQueries({ queryKey: ['sleepHours'] }),
    });


    const deleteWeight = useMutation({
        mutationFn: deleteWeightByIdResponse,
        onSuccess: () =>
            queryClient.invalidateQueries({ queryKey: ['weights'] }),
    });

    const deleteSleepHours = useMutation({
        mutationFn: deleteSleepHoursById,
        onSuccess: () =>
            queryClient.invalidateQueries({ queryKey: ['sleepHours'] }),
    });

    const updateWeight = useMutation({
        mutationFn: ({ id, weightKg, recordedAt }: {
            id: number;
            weightKg: number;
            recordedAt: string;
        }) => updateWeightByIdResponse(id, { weightKg, recordedAt }),
        onSuccess: () =>
            queryClient.invalidateQueries({ queryKey: ['weights'] })
    })

    const updateSleepHours = useMutation({
        mutationFn: ({ id, hours, recordedAt }: {
            id: number,
            hours: number,
            recordedAt: string;
        }) => updateSleepHoursById(id, { hours, recordedAt }),
        onSuccess: () =>
            queryClient.invalidateQueries({ queryKey: ['sleepHours'] })
    })


    function submitWeight(e: SubmitEvent<HTMLFormElement>) {
        e.preventDefault();

        const formData = new FormData(e.currentTarget);
        const weightKg = Number(formData.get('weight'));

        if (!Number.isFinite(weightKg) || weightKg <= 0) {
            return;
        }

        createWeight.mutate({
            weightKg,
            recordedAt: new Date().toISOString(),
        });

    }

    function submitSleepHours(e: SubmitEvent<HTMLFormElement>) {
        e.preventDefault();

        const formData = new FormData(e.currentTarget);
        const hours = Number(formData.get('sleepHours'));

        if (!Number.isFinite(hours) || hours <= 0) {
            return;
        }

        createSleepHours.mutate({
            hours,
            recordedAt: new Date().toISOString(),
        });
    }

    function submitUpdatedWeight(e: SubmitEvent<HTMLFormElement>) {
        e.preventDefault();

        const selectedWeight = weights.find(w => w.id === selectedWeightId);
        if (!selectedWeight) return;

        const formData = new FormData(e.currentTarget);
        const weightKg = Number(formData.get('weight'));

        if (!Number.isFinite(weightKg) || weightKg <= 0) return;

        updateWeight.mutate({
            id: selectedWeight.id,
            weightKg,
            recordedAt: selectedWeight.recordedAt,
        });
    }

    function submitUpdateSleepHours(e: SubmitEvent<HTMLFormElement>) {
        e.preventDefault();

        const selectedSleepHours = sleepHours.find(s => s.id === selectedSleepHoursId);
        if (!selectedSleepHours) return;

        const formData = new FormData(e.currentTarget);
        const hours = Number(formData.get('sleepHours'));

        if (!Number.isFinite(hours) || hours <= 0) return;

        updateSleepHours.mutate({
            id: selectedSleepHours.id,
            hours,
            recordedAt: selectedSleepHours.recordedAt,
        });
    }


    if (weightsPending || hoursPending) {
        return <p>Laddar data...</p>;
    }

    const error = weightsError || hoursError;

    if (error) {
        return <p role="alert">Kunde inte hämta data: {error.message}</p>;
    }


    return (
        <div className={styles.layout}>
            <div className={styles.groupContainer}>
                {/* Each card keeps its form at the top and its entries underneath. */}
                <Card className={styles.card}>
                    <h2>Weight</h2>
                    <div className={styles.weightInputs}>
                        <form onSubmit={submitWeight}>
                            <label htmlFor="weight">Add weight</label>
                            <input
                                id="weight"
                                name="weight"
                                type="text"
                                min="0.1"
                                step="0.1"
                                required
                            />
                            <button
                                type="submit"
                            >Lägg till vikt</button>
                        </form>
                        {createWeight.isSuccess && (
                            <p>Vikten har sparats</p>
                        )}
                    </div>
                    {weights.map((weight) => (
                        <div
                            key={weight.id}
                            className={styles.weightsGroup}
                        >
                            <motion.span
                            >
                                {weight.weightKg}kg
                            </motion.span>

                            <motion.span
                            >
                                {new Date(weight.recordedAt).toLocaleDateString('sv-SE', {
                                    day: 'numeric',
                                    month: 'long',
                                    year: 'numeric',
                                })}
                            </motion.span>

                            <motion.button
                                onClick={() => deleteWeight.mutate(weight.id)}
                            >Radera vikt</motion.button>
                            <motion.button
                                onClick={() => {
                                    setSelectedWeightId(weight.id);
                                    setWeightModalOpen(true);
                                }}
                            >
                                Ändra vikt
                            </motion.button>
                        </div>
                    ))}
                </Card>

                <Card className={styles.card}>
                    <h2>Sleep hours</h2>
                    <div>
                        <form
                            id="create-sleep-hours"
                            onSubmit={submitSleepHours}
                        >
                            <label htmlFor="sleep-hours">Hours</label>
                            <input
                                id="create-sleep-hours"
                                name="sleepHours"
                                type="number"
                                min="0.1"
                                step="0.1"
                                required
                            />
                            <Button
                                type="submit"
                                variant='secondary'
                                disabled={createSleepHours.isPending}
                            >
                                Save hours
                            </Button>
                        </form>

                        {createSleepHours.isError && (
                            <p role="alert">{createSleepHours.error.message}</p>
                        )}
                    </div>
                    {sleepHours.map((hours) => (
                        <div
                            key={hours.id}
                            className={styles.hoursGroup}
                        >
                            <p>Timmar: {hours.hours}</p>
                            <p>Tid: {new Date(hours.recordedAt).toLocaleDateString('sv-SE', {
                                day: 'numeric',
                                month: 'long',
                                year: 'numeric',
                            })}</p>
                            <Button
                                type="button"
                                onClick={() => deleteSleepHours.mutate(hours.id)}
                            >Delete</Button>
                            <Button
                                onClick={() => { setSleepHoursModalOpen(true); setSelectedSleepHoursId(hours.id) }}
                            >Ändra timmar</Button>
                        </div>
                    ))}
                </Card>
            </div>

            {/* The edit modal stays outside the grid cards. */}
            <Modal
                isOpen={weightModalOpen}
                onClose={() => setWeightModalOpen(false)}
                title="TestModal"
                footer={
                    <>
                        <motion.button
                            type="button"
                            onClick={() => setWeightModalOpen(false)}
                        >
                            Avbryt
                        </motion.button>

                        <motion.button
                            form="edit-weight-form"
                            type="submit"
                        >
                            Spara
                        </motion.button>
                    </>
                }
            >
                <form
                    id="edit-weight-form"
                    onSubmit={submitUpdatedWeight}
                >
                    <label>Uppdatera vikt</label>
                    <input
                        id="edit-weight"
                        name="weight"
                        type="number"
                        min="0.1"
                        step="0.1"
                        required
                    />
                </form>
            </Modal>
            <Modal
                isOpen={sleepHoursModalOpen}
                onClose={() => setSleepHoursModalOpen(false)}
                title="Test Sleep Hours"
                footer={
                    <>
                        <Button
                            variant="ghost"
                            onClick={() => setSleepHoursModalOpen(false)}
                        >Avbryt</Button>
                        <Button
                            type="submit"
                            form="edit-sleep-hours-form"
                            variant="primary"
                        >Spara</Button>
                    </>
                }
            >
                <form
                    id="edit-sleep-hours-form"
                    onSubmit={submitUpdateSleepHours}
                >
                    <label>Uppdatera sömntimmar</label>
                    <input
                        id="edit-sleep-hours"
                        name="sleepHours"
                        type="number"
                        required
                    />
                </form>
            </Modal>
        </div>
    );
}
