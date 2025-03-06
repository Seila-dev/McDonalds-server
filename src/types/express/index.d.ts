import * as express from 'express'

declare global {
    namespace Express {
        interface Request {
            user: {
                id: bigint
                email: string
            }
        }
    }
}