#include "DatagramListener.h"

void DatagramListener::Bind(quint16 port) {
	Stop();
	m_port = port;
}

void DatagramListener::SetConsumer(IDataConsumer* consumer) {
	m_consumer = consumer;
}

void DatagramListener::Start() {
	if (m_is_in_progress)
		return;

	m_socket.bind(m_port, QUdpSocket::ShareAddress);
	connect(&m_socket, &QUdpSocket::readyRead, this, &DatagramListener::ProcessDatagrams);
	m_is_in_progress = true;
}

void DatagramListener::Stop() {
	if (!m_is_in_progress)
		return;

	m_socket.abort();
	m_is_in_progress = false;
}

void DatagramListener::ProcessDatagrams() {
	QByteArray datagram;

	while (m_socket.hasPendingDatagrams()) {
		datagram.resize(static_cast<int>(m_socket.pendingDatagramSize()));
		m_socket.readDatagram(datagram.data(), datagram.size());

		if (m_consumer)
			m_consumer->TakeData(datagram);
	}
}

bool DatagramListener::IsInProgress() const {
	return m_is_in_progress;
}

quint16 DatagramListener::Port() const {
	return m_port;
}
