package com.malikov.ticketsystem.service;

import com.malikov.ticketsystem.model.User;

/**
 * @author Yurii Malikov
 */
public interface IUserService extends IService<User> {

    // TODO: 5/14/2017  throws NotFoundException?
    User getByEmail(String email);

}