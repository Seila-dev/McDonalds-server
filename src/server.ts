import { app } from './app'
import usersRoutes from './routes/user-routes'

const port = 3000

app.listen(port, () => {
    console.log(`HTTP Server Running! Server: http://localhost:${port}`)
})

// app uses
app.use("/users", usersRoutes)