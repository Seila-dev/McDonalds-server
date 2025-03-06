import { Request, Response, NextFunction } from 'express'
import jwt from 'jsonwebtoken'
import { prisma } from '../prisma'

export async function authMiddleware(req: Request, res: Response, next: NextFunction) {
    try {
        const token = req.headers['authorization']?.split(' ')[1]

    if(!token) {
        res.status(401).json({ message: "Unauthorized"})
        return
    }

    const payload = jwt.verify(token, 'mysecretkey') as { id: number, email: string }

    const user = await prisma.user.findUnique({
        where: {
            id: payload.id 
        }
    })

    if (!user) {
        res.status(401).json({ message: "Unauthorized" })
        return
    }

    req.user = user

    next()
    } catch (error) {
        res.status(401).json({ message: 'Failed authenticate token'})
    }
    

}