package com.malikov.lowcostairline.service;

import java.util.List;

/**
 * @author Yurii Malikov
 */
public interface IService<T> {

    T save(T t);

    void update(T t);

    // TODO: 5/8/2017 Should name them properties or hints
    T get(long id, String... hintNames);

    List<T> getAll();

    void delete(long id);

}
