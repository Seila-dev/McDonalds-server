import { Request, Response } from 'express';
import { prisma } from '../../prisma'
import bcrypt from 'bcryptjs'
import jwt from 'jsonwebtoken'
//import 'dotenv/config'
require("dotenv").config()

export class UsersController {
    async create(req: Request, res: Response) {
        try {
            const { email, username, passwordHash } = req.body

            const user = await prisma.user.findUnique({
                where: {
                    email
                }
            })

            if (user) {
                res.status(404).json({ error: 'User already exists' })
                return
            }

            const hashedPassword = await bcrypt.hash(passwordHash, 10)

            const newUser = await prisma.user.create({
                data: {
                    email,
                    username,
                    passwordHash: hashedPassword
                }
            })

            res.status(201).json({ newUser })
        } catch (error) {
            res.status(500).send({ message: 'Internal Server Error 2' })
        }

    }

    async login(req: Request, res: Response) {
        const { email, passwordHash } = req.body

        try {
            const user = await prisma.user.findUnique({
                where: {
                    email
                }
            })

            if(user && bcrypt.compareSync(passwordHash, user.passwordHash)) {
                const token = jwt.sign({ id: user.id, email: user.email }, "mysecretkey", { expiresIn: '1h' })
                res.json({ token })
            }

            res.status(401).json({ message: "Invalid credentials "})
        } catch (error) {
            res.status(500).send({ message: 'Internal Server Error '})
        }
    }

    async profile(req: Request, res: Response) {
        res.json(req.user)
    }
}