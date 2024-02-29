/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   mgetter.h                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mait-elk <mait-elk@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/20 11:28:33 by mait-elk          #+#    #+#             */
/*   Updated: 2024/02/29 11:04:20 by mait-elk         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef M_GETTER_H
# define M_GETTER_H
# include <unistd.h>
# include <stdlib.h>
# include <stdarg.h>
# include <string.h>
# include <stdio.h>
# include <curl/curl.h>

typedef enum e_domain_name
{
	None,
	Mediafire,
	FDrive_Cloud
}	t_domain_name;

char	*_nsx_get_direct_url(t_domain_name domname, char *parent_url);

#endif