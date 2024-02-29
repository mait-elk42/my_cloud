/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   mscrapper.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mait-elk <mait-elk@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/21 12:25:16 by mait-elk          #+#    #+#             */
/*   Updated: 2024/02/29 11:04:51 by mait-elk         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <mgetter.h>

static char	*ft_strjoin(char const *s1, char const *s2)
{
	size_t	len;
	char	*res;

	res = 0;
	if (!s1 && !s2)
		return (0);
	if (!s1)
		return (strdup(s2));
	if (!s2)
		return (strdup(s1));
	len = strlen(s1);
	len += strlen(s2);
	res = malloc(len + 1);
	len = 0;
	if (!res)
		return (0);
	while (*s1)
		res[len++] = *s1++;
	while (*s2)
		res[len++] = *s2++;
	res[len] = '\0';
	return (res);
}

size_t Mediafire_Callback(void *buff, size_t size, size_t nmemb, void *dest)
{
	char		**d;
	static int	found_target;

	if (found_target == 2)
	{
		found_target = 0;
		return (0);
	}
	d = (char **)dest;
	if (found_target == 1)
	{
		*d = ft_strjoin(*d, buff);
		found_target = 2;
	}
	else if (strnstr(buff, "Download file", strlen(buff)) && found_target == 0)
	{
		*d = strdup(strnstr(buff, "Download file", strlen(buff)));
		found_target = 1;
	}
    return (size * nmemb);
}

char	*_nsx_substring_adv(char *src, const char *from, const char *to)
{
	char	*res;
	char	*save_src;

	if (!src || !from || !to)
		return (free(src), NULL);
	save_src = src;
	while (*src)
	{
		if (strlen(src) < strlen(from))
			return (free(save_src), NULL);
		if (*src == *from)
		{
			size_t ok = 0;
			while (src[ok] == from[ok])
				ok++;
			if (ok == strlen(from))
				break;
		}
		src++;
	}
	if (!*src)
		return (free(save_src), NULL);
	char *end = strnstr(src, to, strlen(src));
	char save_old_char = *end;
	if (!end)
		return (free(save_src), NULL);
	*end = '\0';
	res = strdup(src);
	*end = save_old_char;
	return (res);
}

char	*_nsx_get_direct_url(t_domain_name domname, char *parent_url)
{
	CURL		*curl;
    CURLcode	res;
    char		*result;

	result = NULL;
	if (domname == None)
		return (NULL);
    curl = curl_easy_init();
	if (!curl)
		return (NULL);
	if (domname == Mediafire)
	{
		curl_easy_setopt(curl, CURLOPT_URL, ft_strjoin("https://www.mediafire.com/file/", parent_url));
    	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, Mediafire_Callback);
	}
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &result);
	res = curl_easy_perform(curl);
    curl_easy_cleanup(curl);
	result = _nsx_substring_adv(result, "http", "\"");
	return (result);
}
