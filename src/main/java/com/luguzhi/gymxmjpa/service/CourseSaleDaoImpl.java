package com.luguzhi.gymxmjpa.service;

import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Service
public class CourseSaleDaoImpl {
    @PersistenceContext
    private EntityManager entityManager;

}
