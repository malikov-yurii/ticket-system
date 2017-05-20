package com.malikov.ticketsystem.repository.jpa;

import com.malikov.ticketsystem.model.City;
import com.malikov.ticketsystem.repository.ICityRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import java.util.List;

/**
 * @author Yurii Malikov
 */
@Repository
@Transactional
public class JpaCityRepositoryImpl implements ICityRepository {

    // TODO: 5/6/2017 should I create? JpaAbstractRepository and put there EnitityManager declaration
    @PersistenceContext
    protected EntityManager em;
    
    @Override
    public City save(City city) {
        if (city.isNew()){
            em.persist((city));
            return city;
        } else {
            return em.merge(city);
        }
    }

    @Override
    public boolean delete(long id) {
        return em.createNamedQuery(City.DELETE).setParameter("id", id).executeUpdate() != 0;
    }

    @Override
    public City get(long id, String... hintNames) {
        return em.find(City.class, id);
    }

    @Override
    public List<City> getAll() {
        return em.createNamedQuery(City.ALL_SORTED, City.class).getResultList();
    }

}