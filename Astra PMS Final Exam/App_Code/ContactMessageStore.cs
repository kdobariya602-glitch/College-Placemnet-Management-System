using System.Collections.Generic;
using System.Web;

namespace Astra_PMS_Final_Exam
{
    // Keeps all Contact Us submissions in Application state (shared across every
    // user/session on the server) so that the Admin side can display them without
    // needing a database. This is what makes a submitted enquiry visible to Admin.
    public static class ContactMessageStore
    {
        private const string Key = "ContactMessages";

        public static List<ContactMessage> GetAll(HttpApplicationState application)
        {
            List<ContactMessage> list = application[Key] as List<ContactMessage>;
            if (list == null)
            {
                list = new List<ContactMessage>();
                application[Key] = list;
            }
            return list;
        }

        public static void Add(HttpApplicationState application, ContactMessage message)
        {
            application.Lock();
            try
            {
                List<ContactMessage> list = GetAll(application);
                list.Insert(0, message); // newest first
            }
            finally
            {
                application.UnLock();
            }
        }
    }
}
