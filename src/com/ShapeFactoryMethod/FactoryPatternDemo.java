package com.ShapeFactoryMethod;

public class FactoryPatternDemo {
    public static void main(String[] args) {
        ShapeFactory shapeFactory = new ShapeFactory();

        Shape shape1 = shapeFactory.getShape("circle");
        shape1.draw();

        Shape shape2 = shapeFactory.getShape("Square");
        shape2.draw();

        Shape shape3 = shapeFactory.getShape("Rectangle");
        shape3.draw();
    }
}
