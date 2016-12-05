using Microsoft.Office.Interop.Word;
using System.IO;
using System.Reflection;

namespace WordToTxt
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length > 0)
                getDocumentText(args[0]);
            else
                getDocumentText(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location) + "\\Resume.docx");
        }

        static void getDocumentText(string doc)
        {
            Application application = new Application();
            try
            {
                Document document = application.Documents.Open(doc);
                string[] paragraphs = new string[document.Paragraphs.Count];

                int position = 0;

                foreach (Paragraph para in document.Paragraphs)
                {
                    paragraphs[position++] = para.Range.Text;
                }

                // Close word.
                application.Quit();
                System.IO.File.WriteAllLines(@"_tempResume.txt", paragraphs);
            }
            catch (System.Runtime.InteropServices.COMException)
            {
                application.Quit();
            }
        }
    }
}
