
const API_URL = import.meta.env.VITE_API_URL;

type WeightResponse = {
    id: number;
    weightKg: number;
    recordedAt: string;
}

type CreateWeightRequest = {
    weightKg: number;
    recordedAt: string;
};

type UpdatedWeightRequest = {
    weightKg: number;
    recordedAt: string;
}

export async function getWeightResponse(): Promise<WeightResponse[]> {
    const response = await fetch(`${API_URL}/api/WeightEntries`);

    if (!response.ok) {
        throw new Error('Could not fetch data')
    }

    return response.json();

}

export async function getWeightByIdResponse(id: number): Promise<WeightResponse> {
    const response = await fetch(`${API_URL}/api/WeightEntries/${id}`);

    if (!response.ok) {
        throw new Error(`Failed to fetch ${id}`);
    }

    return response.json();
}

export async function createWeightResponse(
    weight: CreateWeightRequest
): Promise<WeightResponse> {
    const response = await fetch(`${API_URL}/api/WeightEntries`, {
        method: "POST",
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(weight),
    });

    if (!response.ok) {
        throw new Error('Failed to post weight');
    }

    return response.json();
}

export async function deleteWeightByIdResponse(id: number): Promise<void> {
    const response = await fetch(`${API_URL}/api/WeightEntries/${id}`, {
        method: 'DELETE'
    });

    if (!response.ok) {
        throw new Error('Failed to delete weight');
    }
}

export async function updateWeightByIdResponse(
    id: number,
    updatedWeight: UpdatedWeightRequest):
    Promise<WeightResponse> {
    const response = await fetch(`${API_URL}/api/WeightEntries/${id}`, {
        method: "PUT",
        headers: {
            'Content-Type': "application/json",
        },
        body: JSON.stringify(updatedWeight),
    });

    if (!response.ok) {
        throw new Error('Failed to update weight');
    }

    return response.json();
}