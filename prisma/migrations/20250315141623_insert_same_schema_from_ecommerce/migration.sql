-- CreateTable
CREATE TABLE "ecommerce_categories" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "ecommerce_categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ecommerce_colors" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "ecommerce_colors_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ecommerce_products" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "price" DECIMAL(65,30) NOT NULL,
    "discount" DECIMAL(65,30),
    "rating" DECIMAL(65,30),
    "description" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "color_id" INTEGER NOT NULL,
    "category_id" INTEGER NOT NULL,
    "size_id" INTEGER NOT NULL,
    "highlight" BOOLEAN NOT NULL,
    "ean" TEXT NOT NULL,

    CONSTRAINT "ecommerce_products_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ecommerce_sizes" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "ecommerce_sizes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ecommerce_stocks" (
    "id" SERIAL NOT NULL,
    "product_id" INTEGER NOT NULL,
    "status" TEXT NOT NULL,
    "purchase_price" DECIMAL(65,30) NOT NULL,
    "expiry_date" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "quantity" INTEGER NOT NULL,

    CONSTRAINT "ecommerce_stocks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ecommerce_users" (
    "id" SERIAL NOT NULL,
    "email" TEXT NOT NULL,
    "first_name" TEXT NOT NULL,
    "last_name" TEXT NOT NULL,
    "password_hash" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ecommerce_users_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "ecommerce_products_ean_key" ON "ecommerce_products"("ean");

-- CreateIndex
CREATE UNIQUE INDEX "ecommerce_users_email_key" ON "ecommerce_users"("email");

-- AddForeignKey
ALTER TABLE "ecommerce_products" ADD CONSTRAINT "fk_categories" FOREIGN KEY ("category_id") REFERENCES "ecommerce_categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ecommerce_products" ADD CONSTRAINT "fk_colors" FOREIGN KEY ("color_id") REFERENCES "ecommerce_colors"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ecommerce_products" ADD CONSTRAINT "fk_size" FOREIGN KEY ("size_id") REFERENCES "ecommerce_sizes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ecommerce_stocks" ADD CONSTRAINT "fk_products" FOREIGN KEY ("product_id") REFERENCES "ecommerce_products"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
