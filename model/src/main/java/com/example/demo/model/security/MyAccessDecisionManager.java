package com.example.demo.model.security;

import org.springframework.security.access.AccessDecisionManager;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.access.ConfigAttribute;
import org.springframework.security.authentication.InsufficientAuthenticationException;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Service;

import java.util.Collection;

@Service
public class MyAccessDecisionManager implements AccessDecisionManager {

  /**
   * @param authentication
   * @param object
   * @param configAttributes
   * @throws AccessDeniedException
   * @throws InsufficientAuthenticationException
   */
  @Override
  public void decide(Authentication authentication, Object object, Collection<ConfigAttribute> configAttributes) {
    if (null == configAttributes || configAttributes.size() <= 0) {
      return;
    }
    String needRole;
    for (ConfigAttribute configAttribute : configAttributes) {
      needRole = configAttribute.getAttribute();
      for (GrantedAuthority ga : authentication.getAuthorities()) {
        if (needRole.trim().equals(ga.getAuthority())) {
          return;
        }
      }
    }
    throw new AccessDeniedException("no right");
  }

  /**
   * @param attribute
   * @return
   */
  @Override
  public boolean supports(ConfigAttribute attribute) {
    return true;
  }

  /**
   * @param clazz
   * @return
   */
  @Override
  public boolean supports(Class<?> clazz) {
    return true;
  }

}
