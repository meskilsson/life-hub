import { createFileRoute } from '@tanstack/react-router'
import AnimationsPage from '../pages/AnimationsPage/AnimationsPage'

export const Route = createFileRoute('/animations')({
    component: AnimationsPage,
})

