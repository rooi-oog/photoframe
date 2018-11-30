/* GLIB - Library of useful routines for C programming
 * Copyright (C) 1995-1997  Peter Mattis, Spencer Kimball and Josh MacDonald
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, see <http://www.gnu.org/licenses/>.
 */
 
#include <stdlib.h>
#include <stdint.h>
#include "list.h"

/*
 * Adds a new element on to the end of the list.
 *
 * The return value is the new start of the list, which may
 * have changed, so make sure you store the new value.
 *
 * Note that g_slist_append() has to traverse the entire list
 * to find the end, which is inefficient when adding multiple
 * elements. A common idiom to avoid the inefficiency is to prepend
 * the elements and reverse the list when all elements have been added.
 */
GSList* g_slist_append (GSList *list, void *data)
{
	GSList *new_list;
	GSList *last;

	new_list = malloc (sizeof (GSList));
	new_list->data = data;
	new_list->next = NULL;

	if (list) {
		last = g_slist_last (list);
		/* g_assert (last != NULL); */
		last->next = new_list;

		return list;
	} else
		return new_list;
}

/*
 * Adds a new element on to the start of the list.
 *
 * The return value is the new start of the list, which
 * may have changed, so make sure you store the new value.
 *
 * Returns: the new start of the #GSList
 */
GSList* g_slist_prepend (GSList *list, void *data)
{
	GSList *new_list;

	new_list = malloc (sizeof (GSList));
	new_list->data = data;
	new_list->next = list;

	return new_list;
}

/**
 * g_slist_free:
 * @list: a #GSList
 *
 * Frees all of the memory used by a #GSList.
 * The freed elements are returned to the slice allocator.
 *
 * If list elements contain dynamically-allocated memory,
 * you should either use g_slist_free_full() or free them manually
 * first.
 */
void
g_slist_free (GSList *list)
{
	while (list->next) {
		free (list->next);
	}
	
	free (list);
}

/**
 * g_slist_free_full:
 * @list: a pointer to a #GSList
 * @free_func: the function to be called to free each element's data
 *
 * Convenience method, which frees all the memory used by a #GSList, and
 * calls the specified destroy function on every element's data.
 *
 * @free_func must not modify the list (eg, by removing the freed
 * element from it).
 *
 * Since: 2.28
 **/
void g_slist_free_full (GSList *list, void (*free_func) (void *))
{
#pragma GCC diagnostic ignored "-Wcast-function-type"
	g_slist_foreach (list, (void (*)(void *, void *)) free_func, NULL);
#pragma GCC diagnostic warning "-Wcast-function-type"
	g_slist_free (list);
}

/* Gets the element at the given position in a SList. */
GSList* g_slist_nth (GSList *list, uint32_t n)
{
	while (n-- > 0 && list)
		list = list->next;

	return list;
}

/* Gets the data of the element at the given position. */
void *g_slist_nth_data (GSList *list, uint32_t n)
{
	while (n-- > 0 && list)
		list = list->next;

	return list ? list->data : NULL;
}

/*
 * Finds the element in a #GSList which
 * contains the given data.
 *
 * Returns: the found #GSList element,
 *     or %NULL if it is not found
 */
GSList* g_slist_find (GSList *list, const void *data)
{
	while (list)
	{
		if (list->data == data)
			break;
		list = list->next;
	}

	return list;
}

/*
 * Gets the position of the element containing
 * the given data (starting from 0).
 *
 * Returns: the index of the element containing the data,
 *     or -1 if the data is not found
 */
int g_slist_index (GSList *list, const void *data)
{
	int i = 0;

	while (list)
	{
		if (list->data == data)
			return i;
		i++;
		list = list->next;
	}

	return -1;
}

/* Gets the last element in a SList. */
GSList* g_slist_last (GSList *list)
{
	if (list) {
		while (list->next)
			list = list->next;
	}

	return list;
}

/*
 * Gets the number of elements in a #GSList.
 *
 * This function iterates over the whole list to
 * count its elements. To check whether the list is non-empty, it is faster to
 * check @list against %NULL.
 *
 * Returns: the number of elements in the #GSList
 */
uint32_t g_slist_length (GSList *list)
{
	uint32_t length = 0;
	
	while (list)
	{
		length++;
		list = list->next;
	}

	return length;
}

/**
 * g_slist_foreach:
 * @list: a #GSList
 * @func: the function to call with each element's data
 * @user_data: user data to pass to the function
 *
 * Calls a function for each element of a #GSList.
 *
 * It is safe for @func to remove the element from @list, but it must
 * not modify any part of the list after that element.
 */
void g_slist_foreach (GSList *list, void (*func)(void *, void *), void *user_data)
{
	while (list)
	{
		GSList *next = list->next;
		(*func) (list->data, user_data);
		list = next;
	}
}

