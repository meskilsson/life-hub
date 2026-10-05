import { createFileRoute } from '@tanstack/react-router'
import TrainingPage from '../pages/TrainingPage/TrainingPage'

export const Route = createFileRoute('/training')({
  component: TrainingPage,
})

