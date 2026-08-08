using System;

namespace Astra_PMS_Final_Exam
{
    // Represents one submission from the public Contact Us page.
    public class ContactMessage
    {
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public string City { get; set; }
        public string Message { get; set; }
        public DateTime SubmittedOn { get; set; }
    }
}
