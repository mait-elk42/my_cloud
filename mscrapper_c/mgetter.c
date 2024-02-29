/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   mgetter.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: mait-elk <mait-elk@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/02/20 11:37:38 by mait-elk          #+#    #+#             */
/*   Updated: 2024/02/29 11:29:58 by mait-elk         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <mgetter.h>

int main(int ac, char **av)
{
    if (ac == 1)
        return (printf("Invalid Syntax \nExcepted ./program_name $LINK") , EXIT_FAILURE);
	while (ac-- > 1)
		printf("%s\n", _nsx_get_direct_url(Mediafire, av[ac]));
    return 0;
}
