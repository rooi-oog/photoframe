#ifndef __LIST__H
#define __LIST__H

typedef struct List GSList;

struct List {
	void *data;
	struct List *next;
};

GSList* g_slist_append (GSList *list, void *data);
GSList* g_slist_prepend (GSList *list, void *data);
GSList* g_slist_nth (GSList *list, uint32_t n);
void *g_slist_nth_data (GSList *list, uint32_t n);
GSList* g_slist_find (GSList *list, const void *data);
int g_slist_index (GSList *list, const void *data);
GSList* g_slist_last (GSList *list);
uint32_t g_slist_length (GSList *list);
void g_slist_foreach (GSList *list, void (*func)(void *, void *), void *user_data);

#endif /* __LIST__H */

