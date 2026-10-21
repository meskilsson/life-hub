

const API_URL = import.meta.env.VITE_API_URL;

type SleepHoursResponse = {
    id: number;
    hours: number;
    recordedAt: string;
};

type CreateSleepHoursRequest = {
    hours: number;
    recordedAt: string;
}

type UpdateSleepHoursRequest = {
    hours: number;
    recordedAt: string;
}

export async function getSleepHoursResponse(): Promise<SleepHoursResponse[]> {

    const response = await fetch(`${API_URL}/api/HourEntries`);

    if (!response.ok) {
        throw new Error("Could not fetch data");
    }

    return response.json();
};

export async function createSleepHoursResponse(sleepHours: CreateSleepHoursRequest): Promise<SleepHoursResponse> {

    const response = await fetch(`${API_URL}/api/HourEntries`, {
        method: "POST",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(sleepHours),
    });

    if (!response.ok) {
        throw new Error('Failed to post sleep hours');
    }

    return response.json();
}

export async function deleteSleepHoursById(id: number): Promise<void> {
    const response = await fetch(`${API_URL}/api/HourEntries/${id}/hard`, {
        method: "DELETE",
    });

    if (!response.ok) {
        throw new Error("Failed to delete");
    }
}

export async function updateSleepHoursById(id: number, updatedSleepHours: UpdateSleepHoursRequest): Promise<SleepHoursResponse> {
    const response = await fetch(`${API_URL}/api/HourEntries/${id}`, {
        method: "PUT",
        headers: {
            "Content-Type": "application/json",
        },
        body: JSON.stringify(updatedSleepHours),
    });

    if (!response.ok) {
        throw new Error("Failed to update");
    };

    return response.json();
}