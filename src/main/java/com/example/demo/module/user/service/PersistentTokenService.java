package com.example.demo.module.user.service;

import com.example.demo.config.SiteConfig;
import com.example.demo.module.user.model.RememberMeToken;
import com.example.demo.module.user.repository.RememberMeTokenRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.web.authentication.rememberme.PersistentRememberMeToken;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class PersistentTokenService implements PersistentTokenRepository {

	@Autowired
	private RememberMeTokenRepository rememberMeTokenRepository;
	@Autowired
	private SiteConfig siteConfig;

	@Override
	public void createNewToken(PersistentRememberMeToken token) {

		List<RememberMeToken> tokens = rememberMeTokenRepository.getAllByUsernameOrderByDate(token.getUsername());

		if (tokens != null && tokens.size() >= siteConfig.getLoginPoints()) {
			int end = tokens.size() - siteConfig.getLoginPoints() + 1;
			for (int i = 0; i < end; i++) {
				rememberMeTokenRepository.delete(tokens.get(i));
			}
		}

		RememberMeToken rememberMeToken = new RememberMeToken();
		BeanUtils.copyProperties(token, rememberMeToken);
		rememberMeTokenRepository.save(rememberMeToken);
	}

	@Override
	public void updateToken(String series, String tokenValue, Date lastUsed) {
		RememberMeToken rememberMeToken = rememberMeTokenRepository.getBySeries(series);
		if (rememberMeToken != null) {
			rememberMeToken.setTokenValue(tokenValue);
			rememberMeToken.setDate(lastUsed);
		}
	}

	@Override
	public PersistentRememberMeToken getTokenForSeries(String seriesId) {
		RememberMeToken rememberMeToken = rememberMeTokenRepository.getBySeries(seriesId);
		if (rememberMeToken != null) {
			return new PersistentRememberMeToken(rememberMeToken.getUsername(),
					rememberMeToken.getSeries(), rememberMeToken.getTokenValue(), rememberMeToken.getDate());
		}
		return null;
	}

	@Override
	public void removeUserTokens(String username) {
		rememberMeTokenRepository.deleteByUsername(username);
	}
}
