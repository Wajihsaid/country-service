package com.example.country_service.repositories;
import com.example.country_service.beans.Country;
import org.springframework.data.jpa.repository.JpaRepository;


public interface CountryRepository extends JpaRepository<Country,Integer> {

}