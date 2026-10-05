import { createFileRoute } from '@tanstack/react-router'
import WeightPage from '../pages/WeightPage/WeightPage'

export const Route = createFileRoute('/weight')({
    component: WeightPage,
})

