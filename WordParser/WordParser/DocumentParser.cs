using System;
using Microsoft.Office.Interop.Word;


using RGiesecke.DllExport;             //For DllExport
using System.Runtime.InteropServices;  //For CallingConvention

namespace Parser
{
    class DocumentParser
    {
        [DllExport("getDocumentText", CallingConvention = CallingConvention.Cdecl)]
        static string[] getDocumentText(string doc)
        {
            //string loc = "C:\\Users\\antzy_000\\Documents\\Resume\\Resume.October2016.Base.docx";
            Application application = new Application();
            try
            {
                Document document = application.Documents.Open(doc);
                string[] paragraphs = new string[document.Paragraphs.Count];
                int position = 0;

                foreach(Paragraph para in document.Paragraphs) {
                    paragraphs[position++] = para.Range.Text;
                    Console.WriteLine(paragraphs[position - 1]);
                }

                // Close word.
                application.Quit();
                return paragraphs;
            }
            catch(System.Runtime.InteropServices.COMException)
            {
                application.Quit();
                return null;
            }           
        }


        [DllExport("testLib", CallingConvention = CallingConvention.Cdecl)]
        static void testLib()
        {
            Console.WriteLine("Test Successful");
        }
    }

    
}
