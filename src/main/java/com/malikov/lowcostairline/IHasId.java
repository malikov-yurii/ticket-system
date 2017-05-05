package com.malikov.lowcostairline;

/**
 * @author Yurii Malikov
 */
public interface IHasId {

    Long getId();

    void setId(Long id);

    default boolean isNew(){
        return getId() == null;
    }

}