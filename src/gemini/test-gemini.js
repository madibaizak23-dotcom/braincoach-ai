const { VertexAI } = require('@google-cloud/vertexai');

const PROJECT_ID = 'braincoach-n8n-prod';
const LOCATION = 'europe-west3';

async function testGemini() {
  try {
    console.log('Подключаемся к Vertex AI...');

    const vertexAI = new VertexAI({
      project: PROJECT_ID,
      location: LOCATION,
    });

    const model = vertexAI.getGenerativeModel({
      model: 'gemini-2.5-flash',
    });

    const result = await model.generateContent({
      contents: [
        {
          role: 'user',
          parts: [
            {
              text: 'Ответь одной короткой фразой: BrainCoach AI успешно подключен',
            },
          ],
        },
      ],
    });

    const answer =
      result.response.candidates[0].content.parts[0].text;

    console.log('\nОтвет Gemini:');
    console.log(answer);
  } catch (error) {
    console.error('\nОшибка:');
    console.error(error);
  }
}

testGemini();