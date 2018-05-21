package com.example.demo.model.module.security.repository;

import com.example.demo.model.module.security.model.Permission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by tomoya at 12/26/17
 */
@Repository
public interface PermissionRepository extends JpaRepository<Permission, Integer> {

  Permission findByName(String name);

  Permission findById(int id);

  List<Permission> findByPidGreaterThan(int pid);

  List<Permission> findByPid(int pid);

  void deleteByPid(int pid);

  void delete(Permission permission);

}
