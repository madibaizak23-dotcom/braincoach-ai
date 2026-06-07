   
## DEC-005

Date: 2026-06-05

Decision:

Определить Self Learning Capability как центральный объект исследования BrainCoach.

BrainCoach больше не рассматривает память, внимание, концентрацию или подготовку к экзаменам как центральные объекты системы.

Данные объекты рассматриваются как механизмы или частные контексты применения.

Центральным объектом становится:

* Self Learning Capability

(способность человека самостоятельно осваивать новые знания и навыки без постоянного внешнего управления)

Reason:

Анализ кейсов BrainCoach показал повторяющийся результат в различных доменах:

* образование
* спорт
* нейрообучение
* развитие личности

Несмотря на различие контекстов, успешные кейсы демонстрируют общий паттерн:

переход от внешнего управления к самостоятельному освоению новых задач.

Следовательно Self Learning Capability является более фундаментальным объектом, чем память, внимание, концентрация или экзаменационная подготовка.

Status:

Accepted

Related:

* SELF_LEARNING_CAPABILITY
* CASE_REGISTRY
* RESEARCH_SELF_LEARNING
* PHENOMENON_REGISTRY

## DEC-004

    Date: 2026-06-04

    Decision:

    Принят переход от Single Object Classification к Multi-Object Impact Analysis.

    Knowledge Events больше не рассматриваются как изменения одного объекта знаний.

    Один Knowledge Event может затрагивать несколько Knowledge Objects одновременно.

    Новая модель:

    * knowledge_objects[]

    Вместо:

    * object_type

    Reason:

    Анализ реальных GitHub Push Events показал, что один коммит часто затрагивает несколько доменов BrainCoach Knowledge OS одновременно.

    Пример:

    * Version Registry
    * Ontology
    * Knowledge Layer

    Текущая модель Single Object Classification теряет часть контекста изменений.

    Status:

    Accepted

    Related:

    * Knowledge Event Classification Pipeline
    * Knowledge Object Ontology v1
    * PostgreSQL Data Model v1


## DEC-003

    Title:
    Transition from Thesis-First to Phenomenon-First Content

    Reason:
    Research and early performance data suggest that contradiction creates stronger curiosity than conclusions.

    Impact:
    All future hooks must begin with observation and contradiction before explanation.

    Status:
    Accepted

## DEC-002

    Date: 2026-06-03

    Decision:
    Принята архитектура BrainCoach Knowledge OS v1.0

    Components:

    * Knowledge Layer
    * Research Operations Layer
    * Governance Layer
    * User Memory Layer
    * Infrastructure Layer

    Governance Structure:

    * ADR
    * Decision Log
    * Version Registry
    * Future Candidates

    Reason:
    После формирования Canon Stack возникла необходимость зафиксировать единую операционную архитектуру системы и прекратить неконтролируемое добавление новых сущностей, папок и архитектурных концепций.

    Status:
    Accepted

    Related:

    * ADR-001
    * BrainCoach Knowledge OS v1.0


## DEC-001

    Date: 2026-06-03

    Decision:
    Создан минимальный BrainCoach Canon Stack.

    Components:
    - Canon v1.0
    - Ontology v1.0
    - Phenomenon Registry v1.0
    - Season Registry v1.0

    Reason:
    Необходим единый Source of Truth перед развитием RAG, PostgreSQL и агентной архитектуры.

    Status:
    Accepted

    ---

