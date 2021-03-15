package com.ShapeFactoryMethod;

public class ShapeFactory {
    public Shape getShape(String type) {
        if ("circle".equalsIgnoreCase(type)) {
            return new Circle();
        } else if ("Rectangle".equalsIgnoreCase(type)){
            return new Rectangle();
        } else {
            return new Square();
        }
    }
}
